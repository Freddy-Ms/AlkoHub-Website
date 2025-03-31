from . import db
class RangaUzytkownika(db.Model):
    __tablename__ = 'rangi_uzytkownika'

    id = db.Column(db.Integer, primary_key=True)
    nazwa = db.Column(db.String(15), nullable=False)

    @staticmethod
    def get_all_roles():
        rangas = RangaUzytkownika.query.all()

        result = [{'id': ranga.id, 'ranga': ranga.nazwa} for ranga in rangas]

        return result