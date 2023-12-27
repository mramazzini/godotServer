const router = require("express").Router();
const {
  createLobby,
  getLobby,
  getLobbies,
  removeLobby,
} = require("../controllers/lobbyController");

router.route("/").get(getLobbies);
router.route("/lobby").get(getLobby);
router.route("/").post(createLobby);
router.route("/remove").delete(removeLobby);

module.exports = router;
