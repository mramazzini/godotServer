const router = require("express").Router();
const apiRoutes = require("./ipRoutes");

router.use("/", apiRoutes);

router.use((req, res) => res.send("Wrong route!"));

module.exports = router;