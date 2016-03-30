import * as types from "../constants/action_types";

export function setSubject(text) {
  return {
    type: types.SET_SUBJECT,
    text,
  };
}

export function setModifiers(flags) {
  return {
    type: types.SET_MODIFIERS,
    flags,
  };
}
