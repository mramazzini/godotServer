const { Schema, model } = require("mongoose");

const lobbyQueueSchema = new Schema(
  {
    lobbyId: {
      type: Schema.Types.ObjectId,
      ref: "Lobby",
    },
    createdAt: {
      type: Date,
      default: Date.now,
      expires: 60,
    },
  },
  {
    toJSON: {
      virtuals: true,
    },
  }
);

const LobbyQueue = model("lobbyQueue", lobbyQueueSchema);

module.exports = LobbyQueue;
