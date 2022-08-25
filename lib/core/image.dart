String selectedImage =
    "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";