// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "bootstrap"
import flatpickr from "flatpickr";
import "flatpickr/dist/flatpickr.min.css";


import FlatpickrController from "./controllers/flatpickr_controller";
application.register("flatpickr", FlatpickrController);


document.addEventListener("turbo:load", () => {
  flatpickr(".datepicker", {
    enableTime: false,
    dateFormat: "Y-m-d",
    minDate: "today",
  });
});

