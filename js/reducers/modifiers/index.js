import { SET_MODIFIERS } from "../../constants/action_types";

const initialState = "";

function modifiers(state = initialState, action = undefined) {
  switch (action.type) {
    case SET_MODIFIERS:
      return action.text;

    default:
      return state;
  }
}

export default modifiers;
