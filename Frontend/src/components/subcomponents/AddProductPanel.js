
import React, { useState } from 'react';

const AddProductModal = ({ closeModal, categories }) => {
    const [newProduct, setNewProduct] = useState({
        nazwa: '',
        rodzaj: '',
        opis: '',
        zawartosc_procentowa: '',
        rok_produkcji: '',
        grafika: '',
    });

    const handleInputChange = (e) => {
        const { name, value } = e.target;
        setNewProduct((prevProduct) => ({ ...prevProduct, [name]: value,}));
    };

    const handleAddProduct = async (e) => {
        e.preventDefault();
    
        const { nazwa, rodzaj, opis, zawartosc_procentowa, rok_produkcji, grafika } = newProduct;
    
        const productData = {
          nazwa,
          rodzaj,
          opis,
          zawartosc_procentowa: parseFloat(zawartosc_procentowa),
          rok_produkcji: parseInt(rok_produkcji, 10),
          grafika,
        };
    
        try {
          const response = await fetch('http://localhost:5000/add_alcohol', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json'},
            body: JSON.stringify(productData),
          });
    
          const result = await response.json();
          if (response.ok) {
            alert('Alkohol dodany pomyślnie');
            closeModal();
            window.location.reload();
          } else {
            alert(`Błąd: ${result.message}`);
          }
        } catch (err) {
          alert('Wystąpił błąd podczas dodawania alkoholu');
        }
    };

    return (
        <div className="modal-overlay" onClick={closeModal}>
          <div className="modal-content" onClick={(e) => e.stopPropagation()}>
            <h2>Dodaj Alkohol</h2>
            <form onSubmit={handleAddProduct}>
              <label>
                Nazwa:
                <input 
                  type="text" 
                  name="nazwa" 
                  value={newProduct.nazwa} 
                  onChange={handleInputChange} 
                  required
                />
              </label>
              <label>
                Typ:
                <select 
                  name="rodzaj" 
                  value={newProduct.rodzaj || ""} 
                  onChange={handleInputChange} 
                  required
                >
                  <option value="" disabled hidden>Wybierz typ</option> 
                  {categories.length > 0 ? (
                    categories.map((category, index) => (
                      <option key={index} value={category}>{category}</option>
                    ))
                  ) : (
                    <option disabled>Brak dostępnych kategorii</option>
                  )}
                </select>
              </label>
              <label>
                Zawartość procentowa (%):
                <input 
                  type="number" 
                  name="zawartosc_procentowa" 
                  value={newProduct.zawartosc_procentowa} 
                  onChange={handleInputChange} 
                  step="0.1" 
                  min="0" 
                  required
                />
              </label>
              <label>
                Rok produkcji:
                <input 
                  type="number" 
                  name="rok_produkcji" 
                  value={newProduct.rok_produkcji} 
                  onChange={handleInputChange} 
                  required
                />
              </label>
              <label>
                Opis:
                <textarea 
                  name="opis" 
                  rows="4" 
                  value={newProduct.opis} 
                  onChange={handleInputChange} 
                  required
                />
              </label>
              <label>
                Grafika (URL):
                <input 
                  type="url" 
                  name="grafika" 
                  value={newProduct.grafika} 
                  onChange={handleInputChange} 
                  required
                />
              </label>
              <button type="submit">Dodaj</button>
            </form>
            <button onClick={closeModal}>Zamknij</button>
          </div>
        </div>
    );
};

export default AddProductModal;