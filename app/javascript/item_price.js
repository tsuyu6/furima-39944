window.addEventListener('turbo:load', () => {
  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    // ＃手数料
    const addTaxDom = document.getElementById("add-tax-price");
    const addTax = inputValue * 0.1 
    addTaxDom.innerHTML = addTax;
    
    // ＃販売利益
    const addprofitDom = document.getElementById("profit");
    const addprofit = inputValue * 0.9
    addprofitDom.innerHTML = addprofit

  })
});