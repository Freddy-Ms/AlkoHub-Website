from . import db
class Ulubione(db.Model):
    __tablename__ = 'ulubione'

    id_uzytkownika = db.Column(db.Integer, db.ForeignKey('uzytkownicy.id'), primary_key=True)
    id_alkoholu = db.Column(db.Integer, db.ForeignKey('alkohole.id'), primary_key=True)

    uzytkownik = db.relationship('Uzytkownik', backref='ulubione')
    alkohol = db.relationship('Alkohol', backref='ulubione')

    @staticmethod
    def add_favorite(uzytkownik_id, alkohol_id):
        try:
            new_favorite = Ulubione(id_uzytkownika=uzytkownik_id, id_alkoholu=alkohol_id)
            db.session.add(new_favorite)
            db.session.commit()
            return {"message": "Alkohol został dodany do ulubionych."}, 201
        except Exception as e:
            return {"message": f"Błąd: {str(e)}"}, 500

    @staticmethod
    def delete_favorite(uzytkownik_id, alkohol_id):
        try:
            favorite = Ulubione.query.filter_by(id_uzytkownika=uzytkownik_id, id_alkoholu=alkohol_id).first()
            if not favorite:
                return {"message": "Alkohol nie jest na liście ulubionych."}, 404
            db.session.delete(favorite)
            db.session.commit()
            return {"message": "Alkohol został usunięty z ulubionych."}, 200
        except Exception as e:
            return {"message": f"Błąd: {str(e)}"}, 500
        
    @staticmethod
    def is_favorite(uzytkownik_id, alkohol_id):
        try:
            favorite = Ulubione.query.filter_by(id_uzytkownika=uzytkownik_id, id_alkoholu=alkohol_id).first()
            return favorite is not None
        except Exception as e:
            return {"message": f"Błąd: {str(e)}"}, 500
