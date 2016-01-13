# Description
#   Let Michael Scott interject during your most important business conversations
#
# Configuration:
#   HUBOT_GIPHY_API_KEY - Your Giphy developer API key / they have a public API key "dc6zaTOxFJmzC" if you want to test it out :)
#
# Commands:
#   inspire me michaelscott - gets a random and awesome Michael Scott quote
#   gif me michaelscott <query> - gets an Office gif based on the message you pass in
#
# Notes:
#   Please email me, or post an issue in the Github repository if you want more features!
#
# Author:
#   Abhi Sharma (abhisharma2)

quotes = [
  "The worst thing about prison was the… was the Dementors.",
  "Sometimes I’ll start a sentence and I don’t even know where it’s going. I just hope I find it along the way.",
  "Occasionally I’ll hit somebody with my car. So sue me.",
  "You know what they say. Fool me once, strike one. But fool me twice… strike three.",
  "Then suddenly she’s not your ho no mo.",
  "Would I rather be feared or loved? Easy. Both. I want people to be afraid of how much they love me.",
  "I love inside jokes. I’d love to be a part of one someday.",
  "It’s a pimple, Phyllis. Avril Lavigne gets them all the time, and she rocks harder than anyone alive.",
  "You may look around you and see two different groups of people. White collar… blue collar. But I don’t see it that way. You know why not? Because I am collar blind.",
  "I am Beyoncé, always.",
  "Make friends first, make sales second, make love third. In no particular order.",
  "It’s a good thing Russia doesn’t exist anymore.",
  "I am the early bird and a night owl… so I am wise and I have worms.",
  "In the end, life and business are about human connections. And computers are trying to murder you in a lake.",
  "If I had a gun with two bullets and I was in a room with Hitler, Bin Laden, and Toby, I would shoot Toby twice.",
  "I am running away from my responsibilities. And it feels good."
]

module.exports = (robot) ->

  robot.hear /bankruptcy/i, (res) ->
    res.send "I. DECLARE. BANKRUPTCY!!"

  robot.hear /large|huge|giant|all night|enormous|vast|immense|large|big|great|massive|colossal|prodigious|gigantic|gargantuan|mammoth|monumental|giant|towering|elephantine|mountainous|monstrous|titanic|epic|Herculean|jumbo|mega|monster|king-size|economy-size|oversize|super-size|whopping|humongous/i, (res) ->
    res.send "That's what she said"

  robot.hear /gif me michaelscott ?(.+)?/i, (res) ->
    gifMe res, res.match[1]

  robot.respond /inspire me michaelscott/i, (res) ->
    res.reply res.random quotes

  gifMe = (res, query) ->
    api = process.env.HUBOT_GIPHY_API_KEY || 'dc6zaTOxFJmzC'
    query = query.replace(/\ /g, "+")
    if !api
      res.send "Missing server environment variable HUBOT_GIPHY_API_KEY."
      return
    else
      apiUrl = 'http://api.giphy.com/v1/gifs/translate?s=the+office+' + query + '&api_key=' + api
      res.http(apiUrl)
        .get() (err, res, body) ->
          result = JSON.parse(body)
          if result.error
            res.send "#{result.error}"
            return
          if result.data.length == 0 then res.send "We checked the Internet, couldn't find anything. Try a different search term, like 'bankruptcy'" else res.send result.data.url
