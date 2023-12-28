const { Schema, model } = require("mongoose");

const lobbySchema = new Schema(
  {
    name: {
      type: String,
      required: true,
      unique: true,
      trim: true,
    },
    password: {
      type: String,
      required: true,
      trim: true,
    },
    owner: {
      type: String,
      required: true,
      trim: true,
    },
    port: {
      type: Number,
      required: true,
      trim: true,
    },
  },
  {
    toJSON: {
      virtuals: true,
    },
  }
);

lobbySchema.pre("save", async function (next) {
  const lobby = this;
  const existingLobby = await Lobby.findOne({ name: lobby.name });

  if (!existingLobby) {
    // If the lobby with this name doesn't exist, no need to modify the name
    return next();
  }

  // If the lobby with this name already exists, append a number to make it unique
  let suffix = 1;
  while (true) {
    const newLobbyName = `${lobby.name}${suffix}`;
    const checkExisting = await Lobby.findOne({ name: newLobbyName });

    if (!checkExisting) {
      // Found a unique name, use it
      lobby.name = newLobbyName;
      break;
    }

    // Increment the suffix and try again
    suffix++;
  }

  next();
});

lobbySchema.pre("save", async function (next) {
  const lobby = this;
  const existingLobby = await Lobby.findOne({ port: lobby.port });

  if (!existingLobby) {
    // If the lobby with this port doesn't exist, no need to modify the port
    return next();
  }

  // If the lobby with this port already exists, append a number to make it unique
  let suffix = 1;
  while (true) {
    const newLobbyPort = lobby.port + suffix;
    const checkExisting = await Lobby.findOne({ port: newLobbyPort });

    if (!checkExisting) {
      // Found a unique port, use it
      lobby.port = newLobbyPort;
      break;
    }

    // Increment the suffix and try again
    suffix++;
  }

  next();
});

const Lobby = model("lobby", lobbySchema);

module.exports = Lobby;
