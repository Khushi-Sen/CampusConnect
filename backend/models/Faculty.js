const mongoose = require("mongoose");

const facultySchema = new mongoose.Schema({
  name: String,
  facultyId: String,
  cabin: String,

  timetable: {
    Monday: [{ time: String, room: String }],
    Tuesday: [{ time: String, room: String }],
    Wednesday: [{ time: String, room: String }],
    Thursday: [{ time: String, room: String }],
    Friday: [{ time: String, room: String }],
  },
});

module.exports = mongoose.model("Faculty", facultySchema);