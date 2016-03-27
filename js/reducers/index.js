import { combineReducers } from "redux";
import subject             from "./subject";
import modifiers           from "./modifiers";

const rootReducer = combineReducers({
  modifiers,
  subject,
});

export default rootReducer;
