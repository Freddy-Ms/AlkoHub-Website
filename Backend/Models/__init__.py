from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

from .Uzytkownik import Uzytkownik
from .Alkohol import Alkohol
from .RodzajAlkoholu import RodzajAlkoholu
from .Historia import Historia
from .Opinia import Opinia
from .Osiagniecie import Osiagniecie
from .UkonczoneOsiagniecie import UkonczoneOsiagniecie
from .Ulubione import Ulubione
from .RangaUzytkownika import RangaUzytkownika
