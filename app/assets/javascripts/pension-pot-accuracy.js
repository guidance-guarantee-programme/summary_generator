(function ($) {
  'use strict';

  window.PWO = window.PWO || {};

  var pensionPotAccuracy = {
    init: function () {
      this.cache();
      this.bindEvents();
    },
    cache: function () {
      this.$input = $('input[name="appointment_summary[pension_pot_accuracy]"]');
    },
    bindEvents: function () {
      this.$input.on('change', function () {
        $.publish('accuracyChange', this.value);
      });
    },
  };

  PWO.pensionPotAccuracy = pensionPotAccuracy;

})(jQuery);
