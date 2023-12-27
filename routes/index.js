const router = require("express").Router();
const apiRoutes = require("./lobbyRoutes");

router.use("/", apiRoutes);

router.use((req, res) => res.send("Wrong route!"));

module.exports = router;
