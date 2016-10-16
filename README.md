# GLMath (OpenGL Math) for Swift programming language

A math library for graphics programming. The API is trying to be identical to the data types and builtin functions of OpenGL shader language. The implementation basically piggybacks on the `simd` library.

## Note

- You should always `import Darwin` before `import GLMath`.

- Geometry related constructs like `Quaternion`, `Points`, etc., are defined in separated packages that depend on `GLMath`.

## TODOs

- [ ] Documentation with examples.
- [ ] CI.
- [ ] Works on Linux.

## License

MIT.
