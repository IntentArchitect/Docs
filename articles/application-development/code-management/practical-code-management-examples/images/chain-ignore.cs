builder.Property(x => x.Description)
    // IntentIgnore
    .HasAnnotation("Description", "Display name shown to customers")
    .IsRequired();