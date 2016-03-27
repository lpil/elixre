import { setSubject } from "../../actions";
import subject from ".";

it("has default arguements", () => {
  assert.equal(
    subject(undefined, {}),
    ""
  );
});

it("handles SET_SUBJECT", () => {
  const text   = "hello, world!";
  const action = setSubject(text);
  assert.equal(
    subject(undefined, action),
    text
  );
});
