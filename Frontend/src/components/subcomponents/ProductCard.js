import React from "react";
import "../../styles/ProductCard.css";

const ProductCard = ({ product }) => {
  return (
    <div className="product-card">
      <img
        src={product.image_url}
        alt={product.name}
        className="product-image"
      />
      <h3 className="product-name">{product.nazwa_alkoholu}</h3>
      <p
        className="product-description"
        style={{
          display: "flex",
          flexDirection: "column",
          alignItems: "center",
        }}
      >
        <span>Zawartość:</span>
        <span>{product.zawartosc_procentowa}% </span>
      </p>
    </div>
  );
};

export default ProductCard;
