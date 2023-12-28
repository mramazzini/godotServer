const { Lobby, LobbyQueue } = require("../models");
const { spawn } = require("child_process");
const PORT = 10000;

const path = "godot/rpcServer.sh";

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
      const newLobby = {
        name: req.body.name,
        password: req.body.password,
        owner: req.body.owner,
        port: PORT,
      };

      const lobby = await Lobby.create(newLobby);
      //Add to queue

      const queueItem = await LobbyQueue.create({ lobbyId: lobby._id });

      //Open exe (Application will request port once opened)
      const childProcess = spawn("sh", [path], {
        detached: true,
        stdio: "ignore",
      });

      childProcess.unref();
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
  clearLobbies: async (req, res) => {
    try {
      // remove all lobbies
      const lobbies = await Lobby.deleteMany({});
      res.json(lobbies);
    } catch (err) {
      console.log(err);
      res.sendStatus(500);
    }
  },

  popFromQueue: async (req, res) => {
    try {
      // remove oldest lobby from queue
      const queueItem = await LobbyQueue.findOneAndRemove(
        {},
        { sort: { createdAt: 1 } }
      );
      if (queueItem) {
        // Retrieve lobby information using the lobbyId from the queueItem
        const lobby = await Lobby.findById(queueItem.lobbyId);

        // Now you have the lobby information for server allocation
        console.log(lobby);
        res.json(lobby);
      } else {
        res.sendStatus(404);
      }
    } catch (err) {
      console.log(err);
      res.sendStatus(500);
    }
  },
};
