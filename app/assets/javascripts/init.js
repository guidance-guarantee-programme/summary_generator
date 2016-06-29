$(function () {
  PWO.eligibility.init();
  PWO.pensionPotAccuracy.init();
  PWO.pensionPotInput.init();

  var hasErrors = !!$('.alert-danger').length;
  var isBackFromPreview = !!window.location.search;

  // set up correct UI when displaying form errors and when use has clicked back from preview
  if (hasErrors || isBackFromPreview) {
    // ensure fields for eligible users are displayed
    PWO.eligibility.$input.filter(':checked').trigger('change');

    // ensure correct fields for selected accuracy are displayed
    PWO.pensionPotAccuracy.$input.filter(':checked').trigger('change');
  }
});
