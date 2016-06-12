Template.videoeduItem.helpers
  'videosTitle':->
      @video.title
  'videosSubtitle':->
    if @video.subtitle.length >40
      @video.subtitle.substr(0,40)+"..."
    else
      @video.subtitle
Template.videoeduItem.events
  'mouseover .videoBox':(e)->
    $(e.currentTarget).find('.videoTitle').stop(true,false).animate({"top": "0px"}, 100, "swing");
  'mouseout .videoBox':(e)->
    $(e.currentTarget).find('.videoTitle').stop(true,false).animate({"top": "200px"}, 100, "swing");

