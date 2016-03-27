import modifiers from ".";

it("has default arguments", () => {
  assert.equal(
    modifiers(undefined, {}),
    ""
  );
});
