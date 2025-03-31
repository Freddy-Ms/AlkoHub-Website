from . import db
class RodzajAlkoholu(db.Model):
    __tablename__ = 'rodzaje_alkoholi'

    id = db.Column(db.Integer, primary_key=True)
    nazwa = db.Column(db.String(255), nullable=False)

    @staticmethod
    def get_all_names():
        try:
            rodzaje = RodzajAlkoholu.query.with_entities(RodzajAlkoholu.nazwa).all()
            return [r.nazwa for r in rodzaje]
        except Exception as e:
            raise Exception(f"Error fetching alcohol types: {str(e)}")