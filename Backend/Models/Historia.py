from . import db

class Historia(db.Model):
    __tablename__ = 'historia'

    id_uzytkownika = db.Column(db.Integer, db.ForeignKey('uzytkownicy.id'), primary_key=True)
    id_alkoholu = db.Column(db.Integer, db.ForeignKey('alkohole.id'), primary_key=True)
    data = db.Column(db.DateTime, primary_key=True)
    ilosc_wypitego_ml = db.Column(db.Integer, nullable=False)

    uzytkownik = db.relationship('Uzytkownik', backref='historia')
    alkohol = db.relationship('Alkohol', backref='historia')