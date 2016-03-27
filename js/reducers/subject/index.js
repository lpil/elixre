import { SET_SUBJECT } from "../../constants/action_types";

const initialState = "";

function subject(state = initialState, action = undefined) {
  switch (action.type) {
    case SET_SUBJECT:
      return action.text;

    default:
      return state;
  }
}

export default subject;
