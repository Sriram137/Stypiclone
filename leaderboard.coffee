File = new Meteor.Collection "Stypis"

if Meteor.is_client
    Template.chatspace.message = ->
        File.findOne sel: Session.get "styname"
    Template.chatspace.sessvar = ->
        Session.get "styname"
    Template.chatspace.events =
        'keyup #stypi_space' : ->
            sname = (Session.get "styname")
            if File.find({sel:sname}).count() == 0
                File.insert ({"sel": sname,chat:"Hello World"})
            File.update {sel: sname},$set:
                chat: $("#stypi_space").val()

Routes = Backbone.Router.extend
    routes :
        ":styname" : "main"
    main : (styname) ->
        if !styname
            styname = "9999"
        Session.set "styname",styname

routes = new Routes
if Meteor.is_client
    Meteor.startup -> Backbone.history.start pushState: true
