const router = require("express").Router();
const {
  createLobby,
  getLobby,
  getLobbies,
  removeLobby,
  clearLobbies,
  popFromQueue,
} = require("../controllers/lobbyController");

router.route("/").get(getLobbies);
router.route("/lobby").get(getLobby);
router.route("/").post(createLobby);
router.route("/remove").delete(removeLobby);
router.route("/clear").delete(clearLobbies);
router.route("/pop").delete(popFromQueue);
module.exports = router;
