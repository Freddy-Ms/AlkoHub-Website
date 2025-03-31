from .Historia import Historia
from .UkonczoneOsiagniecie import UkonczoneOsiagniecie
from .RangaUzytkownika import RangaUzytkownika
from . import db
from werkzeug.security import generate_password_hash, check_password_hash
from datetime import datetime, timedelta


#True (1) -> Mężczyzna
#False (0) -> Kobieta


class Uzytkownik(db.Model):
    __tablename__ = 'uzytkownicy'

    id = db.Column(db.Integer, primary_key=True)
    nazwa = db.Column(db.String(15), nullable=False, unique=True)
    mail = db.Column(db.String(50), nullable=False, unique=True)
    haslo = db.Column(db.String(255), nullable=False)
    waga = db.Column(db.Float, nullable=True)
    wiek = db.Column(db.Integer, nullable=True)
    plec = db.Column(db.Boolean, nullable=True)
    ranga = db.Column(db.Integer, db.ForeignKey('rangi_uzytkownika.id'), default=1)

    ranga_rel = db.relationship('RangaUzytkownika', backref='uzytkownicy')
    ukonczone_osiagniecia_rel = db.relationship('UkonczoneOsiagniecie', back_populates='uzytkownik')

    @staticmethod
    def login(nazwa, haslo):
        user = None
        if '@' in nazwa:
            user = Uzytkownik.query.filter_by(mail=nazwa).first()
        else:
            user = Uzytkownik.query.filter_by(nazwa=nazwa).first()
        
        if user and check_password_hash(user.haslo, haslo):
            return user
        return None

    @staticmethod
    def register(data):
        try:
            existing_user_by_nazwa = Uzytkownik.query.filter_by(nazwa=data['nazwa']).first()
            existing_user_by_mail = Uzytkownik.query.filter_by(mail=data['mail']).first()
            
            if existing_user_by_nazwa:
                return {"message": "Błąd rejestracji: Użytkownik z tą nazwą już istnieje."}, 400
            
            if existing_user_by_mail:
                return {"message": "Błąd rejestracji: Użytkownik z tym emailem już istnieje."}, 400

            hashed_password = generate_password_hash(data['haslo'], method='pbkdf2:sha256')
            plec = True if int(data['plec']) == 1 else False
            new_user = Uzytkownik(
                nazwa=data['nazwa'],
                mail=data['mail'],
                haslo=hashed_password,
                waga=data['waga'],
                wiek=data['wiek'],
                plec=plec
            )
            db.session.add(new_user)
            db.session.commit()
            return {"message": "Rejestracja zakończona sukcesem!"}, 201
        except Exception as e:
            return {"message": f"Błąd podczas rejestracji: {str(e)}"}, 500

    @staticmethod
    def get_user_history(uzytkownik_id):
        try:
            historia = Historia.query.filter_by(id_uzytkownika=uzytkownik_id).order_by(Historia.data.desc()).all()

            result = []
            for record in historia:
                result.append({
                    'id_alkoholu': record.alkohol.id,
                    'nazwa_alkoholu': record.alkohol.nazwa_alkoholu,
                    'data': record.data.strftime('%Y-%m-%d %H:%M:%S'),
                    'ilosc_wypitego_ml': record.ilosc_wypitego_ml,
                    'image_url': record.alkohol.image_url,
                    'zawartosc_procentowa': record.alkohol.zawartosc_procentowa
                })
            return result
        except Exception as e:
            return str(e)
        
    @staticmethod
    def get_user_info(uzytkownik_id):
        user = Uzytkownik.query.get(uzytkownik_id)
        if user:
            return {
                "nazwa": user.nazwa,
                "ranga": user.ranga_rel.nazwa if user.ranga_rel else "Brak rangi",
                "wiek": user.wiek,
                "waga": user.waga,
                "plec": "Mężczyzna" if user.plec else "Kobieta",
                "mail": user.mail
            }
        return None

    @staticmethod
    def get_completed_achievements(uzytkownik_id):
        user = Uzytkownik.query.get(uzytkownik_id)
        if user:
            completed_achievements = []
            for completed in user.ukonczone_osiagniecia_rel:
                achievement = completed.osiagniecie  
                completed_achievements.append({
                    "nazwa_osiagniecia": achievement.nazwa_osiagniecia,
                    "data_ukonczenia": completed.data.strftime('%Y-%m-%d') if completed.data else None
                })
            return completed_achievements
        return []
    
    @staticmethod
    def get_waga(uzytkownik_id):
        user = Uzytkownik.query.get(uzytkownik_id)
        return user.waga if user else None

    @staticmethod
    def get_plec(uzytkownik_id):
        user = Uzytkownik.query.get(uzytkownik_id)
        return user.plec if user else None
    
    @staticmethod
    def get_user_history_24h(uzytkownik_id):
        try:
            now = datetime.utcnow()
            last_24h = now - timedelta(days=1)

            historia = Historia.query.filter(
                Historia.id_uzytkownika == uzytkownik_id,
                Historia.data >= last_24h
            ).all()
  

            historia_data = []
            for record in historia:
                alkohol = record.alkohol
                historia_data.append({
                    "nazwa_alkoholu": alkohol.nazwa_alkoholu,
                    "zawartosc_procentowa": alkohol.zawartosc_procentowa,
                    "ilosc_wypitego_ml": record.ilosc_wypitego_ml,
                    "data": record.data.strftime('%Y-%m-%d %H:%M:%S')
                })

            from Functions import calculate_bac
            promile, stan = calculate_bac(uzytkownik_id, historia_data)

            return {
                "promile": promile,
                "stan": stan
            }

        except Exception as e:
            return {"error": str(e)}, 500
    @staticmethod
    def delete_history_entry(user_id, alkohol_id, data):
        try:
            record = Historia.query.filter_by(
                id_uzytkownika=user_id, 
                id_alkoholu=alkohol_id, 
                data=data
            ).first()

            if not record:
                return {"message": "Nie znaleziono wpisu w historii."}, 404

            db.session.delete(record)
            db.session.commit()
            return {"message": "Wpis został usunięty."}, 200

        except Exception as e:
            return {"message": f"Błąd: {str(e)}"}, 500

    @staticmethod
    def add_to_history(user_id, alkohol_id, ilosc_wypitego_ml):
        try:
            new_entry = Historia(
                id_uzytkownika=user_id,
                id_alkoholu=alkohol_id,
                data=datetime.now(),
                ilosc_wypitego_ml=ilosc_wypitego_ml
            )
            db.session.add(new_entry)
            db.session.commit()
            return {"message": "Wpis został dodany."}, 201
        except Exception as e:
            return {"message": f"Błąd: {str(e)}"}, 500
        
    @staticmethod
    def update_user_info(user_id, data):
        try:
            
            user = Uzytkownik.query.get(user_id)
            print(user.wiek, user.waga)
            if not user:
                return {"message": "Użytkownik nie istnieje."}, 404
            if 'waga' in data:
                user.waga = float(data['waga'])
            if 'wiek' in data:
                user.wiek = int(data['wiek'])
            

            db.session.commit()
            return {"message": "Dane użytkownika zaktualizowane pomyślnie.", "success": True}, 200

        except Exception as e:
            db.session.rollback()  
            return {"message": f"Błąd podczas aktualizacji danych użytkownika: {str(e)}"}, 500
        
    @staticmethod
    def get_all_users():
        rangas = RangaUzytkownika.query.filter(RangaUzytkownika.nazwa.in_(['Smakosz', 'Degustator'])).all()
        rang_ids = [ranga.id for ranga in rangas]

        uzytkownicy = Uzytkownik.query.filter(Uzytkownik.ranga.in_(rang_ids)).all()

        result = []
        for uzytkownik in uzytkownicy:
            result.append({
                'id': uzytkownik.id,
                'nazwa': uzytkownik.nazwa,
                'ranga': uzytkownik.ranga_rel.nazwa  
            })
        
        return result

    
    @staticmethod
    def edit_role(user_id, role_id):
        user = Uzytkownik.query.get(user_id)
        if not user:
            return False  


        user.ranga = role_id
        db.session.commit()  
        return True  

