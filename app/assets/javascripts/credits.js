var listStreamers = [];

var streamers = new Vue({
  el: '#streamers',
  data: {
    streamers: [],
    streamer: {
      name: '',
      youtube: '',
      twitch: ''
    },
    errors: {},
    selectedStreamers:listStreamers
  },
  mounted: function() {
    var that;
    that = this;
    $.ajax({
      url: '/credits.json',
      success: function(res) {
        that.streamers = res;
      }
    });
  },
  components: {
    // <my-component> ne sera disponible que dans le template parent
    'my-component': compo
  },
  methods: {
    addStreamer: function () {
      var that = this;
      $.ajax({
        method: 'POST',
        data: {
          streamer: that.streamer,
        },
        url: '/credits.json',
        success: function(res) {
          that.errors = {}
          that.streamers.push(res);
        },
        error: function(res) {
          that.errors = res.responseJSON.errors
        }
      })
    }
  },
  computed:{
    credits: function(){
      var that = this;
      var returnVal = "";
      this.selectedStreamers.forEach(function(strm){
        returnVal += "=====================================================\n";
        returnVal += "\n";
        returnVal += strm.name+"\n";
        returnVal += "\n";
        returnVal += "Youtube : "+strm.youtube+"\n";
        returnVal += "Twitch : "+strm.twitch+"\n";
        returnVal += "\n";
      });
      return returnVal;
    }
  }
});

var compo = Vue.component('streamer-row', {
  template: '#streamer-row',
  props: {
    streamer: Object
  },
  data: function () {
    return {
      editMode: false,
      errors: {},
    }
  },
  methods: {
    updateStreamer: function () {
      var that = this;
      $.ajax({
        method: 'PUT',
        data: {
          streamer: that.streamer,
        },
        url: '/credits/' + that.streamer.id + '.json',
        success: function(res) {
          that.errors = {}
          that.streamer = res
          that.editMode = false
        },
        error: function(res) {
          that.errors = res.responseJSON.errors
        }
      })
    },
    destroyStreamer: function () {
      var that = this;
      $.ajax({
        method: 'DELETE',
        url: '/credits/' + that.streamer.id + '.json',
        success: function(res) {
          that.$el.remove()
        }
      })
    },
    addList:function(elem,$event){
      if(!listStreamers.includes(elem)){
        listStreamers.push(elem);
      }
      else{
        idx = listStreamers.indexOf(elem);
        listStreamers.splice(idx,1);
      }
      console.log(listStreamers);
    }
  }
});

$(document).ready(function(){
  var clipboard = new Clipboard('.clipboard-btn');
  console.log(clipboard);
});


