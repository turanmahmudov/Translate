WorkerScript.onMessage = function(msg) {
    // Get params from msg
    var feed = msg.feed;
    var obj = msg.obj;
    var model = msg.model;

    if (msg.clear_model) {
        model.clear();
    }

    if (feed == "translatePage") {
        for (var i = 0; i < obj.tuc.length; i++) {
            if (typeof(obj.tuc[i].phrase) !== "undefined") {
                var author = obj.authors[obj.tuc[i].authors[0]];

                model.append({"phrase":obj.tuc[i].phrase, "meanings":obj.tuc[i].meanings, "author":author})

                model.sync();
            }
        }
    } else {
        for (var i = 0; i < obj.length; i++) {
            model.append(obj[i]);

            model.sync();
        }
    }
}
