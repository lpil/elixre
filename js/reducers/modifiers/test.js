import { setModifiers } from "../../actions";
import modifiers from ".";

it("has default arguments", () => {
  assert.deepEqual(
    modifiers(undefined, {}),
    {
      valid: true,
      flags: "",
    }
  );
});

it("handles SET_MODIFIERS", () => {
  const flags   = "ui";
  const action = setModifiers(flags);
  assert.deepEqual(
    modifiers(undefined, action),
    {
      valid: true,
      flags,
    }
  );
});
