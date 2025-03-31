import React from 'react';

const FilterPanel = ({ categories, selectedCategories, setSelectedCategories, setIsAddOpen, role }) => {
    const handleCategoryChange = (category) => {
      setSelectedCategories((prev) =>
        prev.includes(category) ? prev.filter((c) => c !== category) : [...prev, category]
      );
    };

    return (
        <div className="filter-container">
            {(role === "Administrator" || role === "Degustator") && (
                <button 
                className="AddProductButton"
                onClick={() => setIsAddOpen(true)}
                >
                Dodaj alkohol
                </button>
            )}
            <h3>Filtry</h3>
            <div className="filter-item">
                <h4>Rodzaj:</h4>
                <div className="category-buttons">
                {categories.map((category, index) => (
                    <button
                    key={index}
                    className={`category-button ${selectedCategories.includes(category) ? 'selected' : ''}`}
                    onClick={() => handleCategoryChange(category)}
                    >
                    {category}
                    </button>
                ))}
                </div>
            </div>
        </div>
    );
};

export default FilterPanel;