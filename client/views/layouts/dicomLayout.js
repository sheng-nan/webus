Template.dicomLayout.rendered = function(){

    // Add gray color for background in blank layout
    $('body').addClass('dicom-bg').css('overflow','hidden');

};

Template.dicomLayout.destroyed = function(){

    // Remove special color for blank layout
    $('body').removeClass('dicom-bg').removeAttr('style');
};