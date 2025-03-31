import { useState, useEffect } from "react";
import "../styles/AddToHistory.css";
import Cookies from 'js-cookie';
import { useNavigate } from 'react-router-dom';

const AddToHistory = () => {
  const [data, setData] = useState([]);
  const [selectedAlcohol, setSelectedAlcohol] = useState(null); 
  const [amount, setAmount] = useState(""); 
  const [userId, setUserId] = useState(null); 
  const navigate = useNavigate();

  useEffect(() => {
    const storedUserId = Cookies.get('user_id');
    if (storedUserId) {
      setUserId(parseInt(storedUserId, 10));
    } else {
      navigate('/login');
    }
  }, [navigate]);

  useEffect(() => {
    fetch("http://localhost:5000/getProducts")
      .then((response) => response.json())
      .then((data) => {
        setData(data);
      })
      .catch((error) => console.error("Error fetching products:", error));
  }, []);

  const handleAddToHistory = () => {
    if (!userId) {
      alert("Brak zalogowanego użytkownika.");
      return;
    }

    if (selectedAlcohol && amount) {
      fetch(`http://localhost:5000/add_to_history/${userId}/${selectedAlcohol.id}`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          ilosc_wypitego_ml: parseInt(amount, 10),
        }),
      })
        .then((response) => response.json())
        .then((result) => {
          if (result.message) {
            alert("Dodano pomyślnie");
            navigate("/history");
          } else {
            alert("Błąd: " + result.error);
          }
        })
        .catch((error) => console.error("Error adding to history:", error));
    } else {
      alert("Wybierz alkohol i podaj ilość.");
    }
  };

  const SearchableDropdown = ({ data, onAlcoholSelect, selectedAlcohol }) => {
    const [searchTerm, setSearchTerm] = useState(""); 
    const [isOpen, setIsOpen] = useState(false);

    const filteredData = data.filter((item) =>
      item.nazwa_alkoholu.toLowerCase().includes(searchTerm.toLocaleLowerCase())
    );

    const handleItemClick = (item) => {
      onAlcoholSelect(item); 
      setSearchTerm(item.nazwa_alkoholu); 
      setIsOpen(false);
    };

    const handleFocus = () => setIsOpen(true);
    const handleBlur = () => setTimeout(() => setIsOpen(false), 200);

    const handleChangeSearchTerm = (e) => {
      const value = e.target.value;
      setSearchTerm(value); 
      if (value === "") {
        onAlcoholSelect(null);
      } else if (!selectedAlcohol || selectedAlcohol.nazwa_alkoholu !== value) {
        onAlcoholSelect(null);
      }
    };

    return (
      <div className="dropdown-container">
        <input
          type="text"
          value={selectedAlcohol ? selectedAlcohol.nazwa_alkoholu : searchTerm}
          onChange={handleChangeSearchTerm}
          onFocus={handleFocus}
          onBlur={handleBlur}
          placeholder={selectedAlcohol ? "" : "Wyszukaj alkohol..."} 
        />
        {isOpen && !selectedAlcohol && (
          <div className="dropdown-list">
            {filteredData.length > 0 ? (
              filteredData.map((item, index) => (
                <button
                  key={index}
                  className="dropdown-item"
                  onClick={() => handleItemClick(item)}
                >
                  {item.nazwa_alkoholu}
                </button>
              ))
            ) : (
              <div className="dropdown-item">Brak wyników</div>
            )}
          </div>
        )}
      </div>
    );
  };

  return (
    <div className="login-container">
      <h1>Dodawanie alkoholu do historii</h1>
      <SearchableDropdown
        data={data}
        onAlcoholSelect={(alcohol) => setSelectedAlcohol(alcohol)}
        selectedAlcohol={selectedAlcohol}
      />
      {selectedAlcohol && (
        <div className="amount-container">
          <label htmlFor="amount">Ilość (ml):</label>
          <input
            id="amount"
            type="text"
            value={amount}
            onChange={(e) => {
              const value = e.target.value;
              if (/^\d*$/.test(value)) setAmount(value); 
            }}
            placeholder="Wpisz ilość w ml"
          />
        </div>
      )}
      {selectedAlcohol && amount && (
        <button className="add-button" onClick={handleAddToHistory}>
          Dodaj
        </button>
      )}
    </div>
  );
};

export default AddToHistory;
