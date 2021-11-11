if (window.currentDiscussionID !== undefined) {

    var app = new Vue({
      el: "#comments-app",
      data: {
        discussion: null,
      }
    })

    const getDiscussion = async () => {
        const response = await fetch(`https://data.diegolavalle.com/discussion/${window.currentDiscussionID}.json`)
        app.discussion = await response.json()
    }

    getDiscussion()
}
