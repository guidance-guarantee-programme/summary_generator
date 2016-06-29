(function ($) {
  'use strict';

  window.PWO = window.PWO || {};

  var pensionPotAccuracy = {
    init: function () {
      this.cache();
      this.bindEvents();
      this.subscribe();
    },
    cache: function () {
      this.$input = $('input[name="appointment_summary[pension_pot_accuracy]"]');
    },
    bindEvents: function () {
      this.$input.on('change', function () {
        $.publish('accuracyChange', this.value);
      });
    },
    subscribe: function () {
      var that = this;
      $.subscribe('eligibilityChange', function (e, value) {
        if (value === 'no') {
          that.$input.prop('checked', false);
          that.$input.trigger('change');
        }
      });
    }
  };

  PWO.pensionPotAccuracy = pensionPotAccuracy;

})(jQuery);
