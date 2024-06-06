document.addEventListener("turbo:load", () => {
  const dropdownButtons = document.querySelectorAll(
    "[data-dropdown-selection-toggle]"
  );
  const dropdownMenus = document.querySelectorAll(
    "[data-dropdown-selection-menu]"
  );

  function toggleDropdown(event) {
    const dropdownId = event.currentTarget.getAttribute(
      "data-dropdown-selection-toggle"
    );
    const dropdownMenu = document.querySelector(
      `[data-dropdown-selection-menu="${dropdownId}"]`
    );
    dropdownMenu.classList.toggle("hidden");
  }

  function closeDropdowns(event) {
    dropdownMenus.forEach((menu) => {
      if (
        !menu.contains(event.target) &&
        !document
          .querySelector(
            `[data-dropdown-selection-toggle="${menu.getAttribute(
              "data-dropdown-selection-menu"
            )}"]`
          )
          .contains(event.target)
      ) {
        menu.classList.add("hidden");
      }
    });
  }

  dropdownButtons.forEach((button) => {
    button.addEventListener("click", toggleDropdown);
  });

  document.addEventListener("click", closeDropdowns);

  // Add the event listener for selection items
  document.querySelectorAll("[data-selection-item]").forEach((item) => {
    item.addEventListener("click", function () {
      const selectionItem = this.getAttribute("data-selection-item");
      const toggleId = this.getAttribute("data-selection-toggle-id");
      const hiddenId = this.getAttribute("data-selection-hidden-id");

      // Update the text of the toggle button
      const toggleElement = document.getElementById(toggleId);
      toggleElement.childNodes[0].textContent =
        selectionItem.charAt(0).toUpperCase() + selectionItem.slice(1);

      // Update the value of the hidden field
      const hiddenElement = document.getElementById(hiddenId);
      hiddenElement.value = selectionItem;

      // Close the dropdown menu
      const dropdownMenu = document.querySelector(
        `[data-dropdown-selection-menu="${toggleId}"]`
      );
      dropdownMenu.classList.add("hidden");
    });
  });
});
