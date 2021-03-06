(function ($) {
  'use strict';

  window.PWO = window.PWO || {};

  var pensionPot = {
    init: function() {
      this.cache();
      this.subscribe();
      this.bindEvents();
      this.ensureCorrectState();
    },

    cache: function () {
      this.$eligibilityWrapper = $('.js-display-if-eligible');
      this.$rangeWrapper = $('.js-display-if-range');
      this.$numberInputs = $('.js-numbers-only');
      this.$eligibilityInput = $('.js-defined-contribution-option');
      this.$accuracyInput = $('.js-pot-accuracy-option');
      this.$potSizeInput = $('.js-pot-value');
      this.$potUpperSizeInput = $('.js-upper-pot-value');
      this.$potCountInput = $('.js-pot-count');
      this.$firstAppointmentInput = $('.js-first-appointment');
      this.$appointmentCountWrapper = $('.js-previous-appointments');
      this.$noPreviousAppointmentsInput = $('.js-previous-appointment-0');
      this.$onePreviousAppointmentInput = $('.js-previous-appointment-1');
    },

    bindEvents: function () {
      this.$eligibilityInput.on('change', function () {
        $.publish('eligibilityChange', this.value);
      });

      this.$accuracyInput.on('change', function () {
        $.publish('accuracyChange', this.value);
      });

      this.$numberInputs.on('keypress', function (e) {
        //if the letter is not digit then display error and don't type anything
        if (e.which !== 8 && e.which !== 0 && (e.which < 48 || e.which > 57)) {
          var error_input = $(e.target).parents('.form-group').find('.js-error-message');
          error_input.html('Only use numbers').show().attr('aria-live', 'polite').fadeOut('slow');
          return false;
        }
      });

      this.$firstAppointmentInput.on('change', function () {
        $.publish('firstAppointmentChange', this.value);
      });
    },

    subscribe: function () {
      var that = this;

      $.subscribe('accuracyChange', function (e, value) {
        if (value === 'range') {
          that.$rangeWrapper.fadeIn();
        } else {
          that.$rangeWrapper.fadeOut();
          that.$potUpperSizeInput.val('').trigger('keyup');
        }

        if (value === 'notprovided') {
          that.$potSizeInput.val('').trigger('keyup');
          that.$potUpperSizeInput.val('').trigger('keyup');
          that.$potCountInput.val('').trigger('keyup');
        }
      });

      $.subscribe('eligibilityChange', function (e, value) {
        if (value === 'no') {
          that.$eligibilityWrapper.fadeOut();

          that.$potSizeInput.val('').trigger('keyup');
          that.$potUpperSizeInput.val('').trigger('keyup');
          that.$potCountInput.val('').trigger('keyup');

          that.$accuracyInput.prop('checked', false);
          $.publish('accuracyChange', '');
        } else {
          that.$eligibilityWrapper.fadeIn();
        }
      });

      $.subscribe('firstAppointmentChange', function (e, value) {
        if (value === 'yes') {
          that.$noPreviousAppointmentsInput.prop('checked', true);
          that.$appointmentCountWrapper.fadeOut();
        } else {
          that.$appointmentCountWrapper.fadeIn().attr('aria-live', 'polite');
          if (that.$noPreviousAppointmentsInput.prop('checked')) {
            that.$onePreviousAppointmentInput.prop('checked', true);
          }
        }
      });
    },

    ensureCorrectState: function() {
      this.$eligibilityInput.filter(':checked').trigger('change');
      this.$accuracyInput.filter(':checked').trigger('change');
      this.$firstAppointmentInput.filter(':checked').trigger('change');
    }
  };

  PWO.pensionPot = pensionPot;
})(jQuery);
