from . import db
from sqlalchemy import CheckConstraint
from datetime import datetime

class Opinia(db.Model):
    __tablename__ = 'opinie'

    id_alkoholu = db.Column(db.Integer, db.ForeignKey('alkohole.id'), primary_key=True)
    id_uzytkownika = db.Column(db.Integer, db.ForeignKey('uzytkownicy.id'), primary_key=True)
    znacznik_czasu = db.Column(db.DateTime, nullable=False)
    ocena = db.Column(db.Integer, nullable=True)
    recenzja = db.Column(db.Text, nullable=True)

    __table_args__ = (
        db.UniqueConstraint('id_uzytkownika', 'id_alkoholu', name='unique_user_alcohol'),
        CheckConstraint('ocena >= 1 AND ocena <= 5', name='check_ocena_range'),
    )

    alkohol = db.relationship('Alkohol', backref='opinie')
    uzytkownik = db.relationship('Uzytkownik', backref='opinie')

    @staticmethod
    def add_opinion(data):
        try:
            if not all(key in data for key in ['produkt_id', 'user_id', 'ocena', 'recenzja']):
                return {"message": "Brak wymaganych danych."}, 400

            if not (1 <= data['ocena'] <= 5):
                return {"message": "Ocena musi być w zakresie od 1 do 5."}, 400
            
            existing_opinion = Opinia.query.filter_by(
            id_alkoholu=data['produkt_id'],
            id_uzytkownika=data['user_id']
            ).first()

            if existing_opinion:
                return ({"message": "Już wystawiłeś opinię o tym produkcie."}), 409
            
            nowa_opinia = Opinia(
                id_alkoholu=data['produkt_id'],
                id_uzytkownika=data['user_id'],
                znacznik_czasu=datetime.utcnow(),
                ocena=data['ocena'],
                recenzja=data['recenzja']
            )

            db.session.add(nowa_opinia)
            db.session.commit()
            return {"message": "Opinia została dodana pomyślnie.", "success": True}, 201

        except db.IntegrityError:
            db.session.rollback()
            return {"message": "Opinia dla tego produktu już istnieje."}, 409

        except Exception as e:
            db.session.rollback()
            return {"message": f"Błąd podczas dodawania opinii: {str(e)}"}, 500
        
    @staticmethod
    def check_user_opinion(user_id, alkohol_id):
        try:
            opinia = db.session.query(Opinia).filter_by(id_uzytkownika=user_id, id_alkoholu=alkohol_id).first()

            if opinia:
                return {'exists': True}
            else:
                return {'exists': False}

        except Exception as e:
            return {"message": f"Błąd serwera: {str(e)}"}
        
    @staticmethod
    def update_opinion(user_id, alkohol_id, ocena, recenzja):
        try:
            opinia = db.session.query(Opinia).filter_by(id_uzytkownika=user_id, id_alkoholu=alkohol_id).first()

            if opinia:
                if ocena:
                    opinia.ocena = ocena
                if recenzja:
                    opinia.recenzja = recenzja
                db.session.commit()

                return {'message': 'Opinia została zaktualizowana pomyślnie'}, 200
            else:
                return {'message': 'Opinia nie została znaleziona'}, 404

        except Exception as e:
            return {"message": f"Błąd serwera: {str(e)}"}, 500
        
    @staticmethod
    def get_all_opinions_for_user(user_id):
        try:
            from .Alkohol import Alkohol
            opinions = db.session.query(Opinia, Alkohol).join(Alkohol).filter(
                Opinia.id_uzytkownika == user_id
            ).all()
            
            if not opinions:
                return {"message": "Brak opinii dla tego użytkownika."}, 404

            result = [
                {
                    'image_url': alkohol.image_url,
                    'nazwa_alkoholu': alkohol.nazwa_alkoholu,
                    'ocena': opinia.ocena,
                    'recenzja': opinia.recenzja,
                    'znacznik_czasu': opinia.znacznik_czasu,
                    'id_alkoholu': opinia.id_alkoholu
                }
                for opinia, alkohol in opinions
            ]
            return result, 200

        except Exception as e:
            return {"message": f"Błąd podczas pobierania opinii: {str(e)}"}, 500