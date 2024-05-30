document.addEventListener("DOMContentLoaded", function () {
  document.querySelectorAll("[data-dropdown]").forEach(function (dropdown) {
    dropdown.addEventListener("click", function (event) {
      console.log("Clicked Item");
      event.stopPropagation();
      const dropdownContent = this.querySelector(".dropdown-content");
      dropdownContent.classList.toggle("block");
      dropdownContent.classList.toggle("hidden");
    });
  });

  // Close the dropdown if the user clicks outside of it
  window.addEventListener("click", function (event) {
    document.querySelectorAll("[data-dropdown]").forEach(function (dropdown) {
      if (!dropdown.contains(event.target)) {
        dropdown.querySelector(".dropdown-content").classList.remove("block");
        dropdown.querySelector(".dropdown-content").classList.add("hidden");
      }
    });
  });
});
