if (window.currentDiscussionID !== undefined) {

    var app = new Vue({
      el: "#comments-app",
      data: {
        loading: true,
        discussion: null,
      }
    })

    const getDiscussion = async () => {
        const response = await fetch(`https://data.diegolavalle.com/discussion/${window.currentDiscussionID}.json`)
        if (response.status == 200) {
            app.discussion = await response.json()
        }
        app.loading = false
    }

    getDiscussion()
}
