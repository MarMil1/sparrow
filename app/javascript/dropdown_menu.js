document.addEventListener("turbo:load", () => {
  const dropdownButtons = document.querySelectorAll(
    "[data-dropdown-menu-toggle]"
  );
  const dropdownMenus = document.querySelectorAll("[data-dropdown-menu-menu]");

  function toggleDropdown(event) {
    const dropdownId = event.currentTarget.getAttribute(
      "data-dropdown-menu-toggle"
    );
    const dropdownMenu = document.querySelector(
      `[data-dropdown-menu-menu="${dropdownId}"]`
    );
    dropdownMenu.classList.toggle("hidden");
  }

  function closeDropdowns(event) {
    dropdownMenus.forEach((menu) => {
      if (
        !menu.contains(event.target) &&
        !document
          .querySelector(
            `[data-dropdown-menu-toggle="${menu.getAttribute(
              "data-dropdown-menu-menu"
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
});
