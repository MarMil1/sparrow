document.addEventListener("DOMContentLoaded", function () {
  document.addEventListener("click", function (event) {
    const toggle = event.target.closest("[data-dropdown-toggle]");
    if (toggle) {
      event.stopPropagation();
      const dropdownContent = toggle
        .closest("[data-dropdown]")
        .querySelector(".dropdown-content");
      dropdownContent.classList.toggle("hidden");
    } else {
      // Close the dropdown if the user clicks outside of it
      document.querySelectorAll("[data-dropdown]").forEach(function (dropdown) {
        dropdown.querySelector(".dropdown-content").classList.add("hidden");
      });
    }
  });
});
