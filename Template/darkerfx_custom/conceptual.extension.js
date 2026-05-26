exports.preTransform = function (model) {
  return model;
}

exports.postTransform = function (model) {
  if (model._path) {
    model._mdPath = model._path.replace(/\.html$/, '.md');
  }
  return model;
}
