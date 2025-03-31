from datetime import datetime
from sqlalchemy import func
from Models import db, Historia, Osiagniecie, UkonczoneOsiagniecie, Alkohol  

def check_and_assign_achievements(user_id, alkohol_id):
    try:
        alkohol_record = Alkohol.query.filter_by(id=alkohol_id).first()
        if not alkohol_record:
            return {"message": "Nie znaleziono alkoholu."}, 404

        rodzaj_alkoholu_id = alkohol_record.rodzaj_alkoholu

        possible_achievements = Osiagniecie.query.filter(
            (Osiagniecie.rodzaj_alkoholu == rodzaj_alkoholu_id) | (Osiagniecie.rodzaj_alkoholu == None)
        ).all()

        user_achievements = db.session.query(UkonczoneOsiagniecie.id_osiagniecia).filter_by(id_uzytkownika=user_id).all()
        user_achievements_ids = {achievement.id_osiagniecia for achievement in user_achievements}

        history_for_kind = db.session.query(func.sum(Historia.ilosc_wypitego_ml)).filter(
            Historia.id_uzytkownika == user_id,
            Historia.id_alkoholu == alkohol_id
        ).scalar() or 0

        history_all = db.session.query(func.sum(Historia.ilosc_wypitego_ml)).filter(
            Historia.id_uzytkownika == user_id
        ).scalar() or 0

        new_achievements = []

        for achievement in possible_achievements:
            if achievement.id_osiagniecia in user_achievements_ids:
                continue  

            required_amount = achievement.ilosc_wymagana_ml

            if achievement.rodzaj_alkoholu == rodzaj_alkoholu_id:
                if history_for_kind >= required_amount:
                    new_achievements.append(achievement)
            elif achievement.rodzaj_alkoholu is None:
                if history_all >= required_amount:
                    new_achievements.append(achievement)

        for achievement in new_achievements:
            new_record = UkonczoneOsiagniecie(
                id_osiagniecia=achievement.id_osiagniecia,
                id_uzytkownika=user_id,
                data=datetime.now()
            )
            db.session.add(new_record)

        db.session.commit()
        return {"message": f"Dodano {len(new_achievements)} nowych osiągnięć."}, 200

    except Exception as e:
        db.session.rollback()
        return {"message": f"Błąd: {str(e)}"}, 500


def check_and_remove_achievements(user_id, alkohol_id):
    try:
        alkohol_record = Alkohol.query.filter_by(id=alkohol_id).first()
        if not alkohol_record:
            return {"message": "Nie znaleziono alkoholu."}, 404

        rodzaj_alkoholu_id = alkohol_record.rodzaj_alkoholu

        user_achievements = UkonczoneOsiagniecie.query.filter_by(id_uzytkownika=user_id).all()

        history_for_kind = db.session.query(func.sum(Historia.ilosc_wypitego_ml)).filter(
            Historia.id_uzytkownika == user_id,
            Historia.id_alkoholu == alkohol_id
        ).scalar() or 0

        history_all = db.session.query(func.sum(Historia.ilosc_wypitego_ml)).filter(
            Historia.id_uzytkownika == user_id
        ).scalar() or 0

        removed_achievements = []

        for user_achievement in user_achievements:
            achievement = Osiagniecie.query.filter_by(id_osiagniecia=user_achievement.id_osiagniecia).first()
            if not achievement:
                continue

            required_amount = achievement.ilosc_wymagana_ml

            if achievement.rodzaj_alkoholu == rodzaj_alkoholu_id:
                if history_for_kind < required_amount:
                    removed_achievements.append(user_achievement)
            elif achievement.rodzaj_alkoholu is None:
                if history_all < required_amount:
                    removed_achievements.append(user_achievement)

        for achievement in removed_achievements:
            db.session.delete(achievement)

        db.session.commit()
        return {"message": f"Usunięto {len(removed_achievements)} osiągnięć."}, 200

    except Exception as e:
        db.session.rollback()
        return {"message": f"Błąd: {str(e)}"}, 500