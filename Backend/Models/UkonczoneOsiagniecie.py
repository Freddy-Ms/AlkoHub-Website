from . import db
class UkonczoneOsiagniecie(db.Model):
    __tablename__ = 'ukonczone_osiagniecia'

    id_osiagniecia = db.Column(db.Integer, db.ForeignKey('osiagniecia.id_osiagniecia'), primary_key=True)
    id_uzytkownika = db.Column(db.Integer, db.ForeignKey('uzytkownicy.id'), primary_key=True)
    data = db.Column(db.Date, nullable=True)

    osiagniecie = db.relationship('Osiagniecie', backref='ukonczone')
    uzytkownik = db.relationship('Uzytkownik', back_populates='ukonczone_osiagniecia_rel')