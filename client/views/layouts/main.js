Template.mainLayout.rendered = function(){

    // Add special class for handel top navigation layout
    $('body').addClass('top-navigation');

}

Template.mainLayout.destroyed = function(){

    // Remove special top navigation class
    $('body').removeClass('top-navigation');
};