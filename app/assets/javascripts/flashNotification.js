document.addEventListener("DOMContentLoaded", function () {
  var closeFlashButton = document.getElementById("close-flash");
   var justClose = document.getElementById("close-flash-button");
   
       if (closeFlashButton) {
         closeFlashButton.addEventListener("click", function () {
           var actionUrl = closeFlashButton.getAttribute("data-action-url");

           // Perform AJAX request
           var xhr = new XMLHttpRequest();
           xhr.open("GET", actionUrl, true);
           xhr.setRequestHeader("X-Requested-With", "XMLHttpRequest");
           xhr.send();

           // Hide the flash message
           var flashMessage = document.getElementById("flash-message");
           flashMessage.style.display = "none";
         });
       }
});
