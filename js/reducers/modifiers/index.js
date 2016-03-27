import { SET_MODIFIERS } from "../../constants/action_types";

const initialState = { flags: "", valid: true };

function modifiers(state = initialState, action = undefined) {
  switch (action.type) {
    case SET_MODIFIERS:
      return Object.assign(state, { flags: action.flags });

    default:
      return state;
  }
}

export default modifiers;
