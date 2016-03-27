import { setModifiers } from "../../actions";
import modifiers from ".";

it("has default arguments", () => {
  assert.equal(
    modifiers(undefined, {}),
    ""
  );
});

it("handles SET_MODIFIERS", () => {
  const text   = "ui";
  const action = setModifiers(text);
  assert.equal(
    modifiers(undefined, action),
    text
  );
});
