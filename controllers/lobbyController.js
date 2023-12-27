const { Lobby } = require("../models");

module.exports = {
  getLobbies: async (req, res) => {
    try {
      const lobbies = await Lobby.find({});
      res.json(lobbies);
    } catch (err) {
      console.log(err);
      res.sendStatus(500);
    }
  },
  getLobby: async (req, res) => {
    try {
      // find lobby by lobbyName
      const lobby = await Lobby.findOne({ name: req.body.name });
      console.log(lobby);
      if (lobby) {
        res.json(lobby);
      } else {
        res.sendStatus(404);
      }
    } catch (err) {
      console.log(err);
      res.sendStatus(500);
    }
  },
  createLobby: async (req, res) => {
    try {
      // create lobby
      const lobby = await Lobby.create(req.body);
      res.json(lobby);
    } catch (err) {
      console.log(err);
      res.sendStatus(500);
    }
  },
  removeLobby: async (req, res) => {
    try {
      // remove lobby by lobbyName
      const lobby = await Lobby.findOneAndRemove({ name: req.body.name });
      res.json(lobby);
    } catch (err) {
      console.log(err);
      res.sendStatus(500);
    }
  },
};
