from . import db
class Osiagniecie(db.Model):
    __tablename__ = 'osiagniecia'

    id_osiagniecia = db.Column(db.Integer, primary_key=True)
    rodzaj_alkoholu = db.Column(db.Integer, db.ForeignKey('rodzaje_alkoholi.id'))
    nazwa_osiagniecia = db.Column(db.String(30), nullable=False)
    opis_osiagniecia = db.Column(db.Text, nullable=True)
    ilosc_wymagana_ml = db.Column(db.Integer, nullable=False)

    rodzaj_alkoholu_rel = db.relationship('RodzajAlkoholu', backref='osiagniecia')

    @staticmethod
    def get_all_osiagniecia():
        try:
            osiagniecia = Osiagniecie.query.all()
            osiagniecia_list = []
            for osiagniecie in osiagniecia:
                osiagniecia_list.append({
                    'id_osiagniecia': osiagniecie.id_osiagniecia,
                    'rodzaj_alkoholu': osiagniecie.rodzaj_alkoholu,
                    'nazwa_osiagniecia': osiagniecie.nazwa_osiagniecia,
                    'opis_osiagniecia': osiagniecie.opis_osiagniecia,
                    'ilosc_wymagana_ml': osiagniecie.ilosc_wymagana_ml
                })
            return osiagniecia_list
        except Exception as e:
            return str(e)