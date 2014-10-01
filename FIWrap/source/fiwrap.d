module fiwrap;
import derelict.freeimage.freeimage;

class FIBitmap
{
	FIBITMAP *img;
	//custom
	this(FIBITMAP *image)
	{
		img = image;
	}
	
	//allocateT
	this(FREE_IMAGE_TYPE type, int width, int height, int bpp = 8, uint red_mask = 0, uint green_mask = 0, uint blue_mask = 0 )
	{
		img = FreeImage_AllocateT( type, width, height, bpp = 8, red_mask,green_mask,blue_mask);
	}	
	
	//allocate	
	this( int width, int height, int bpp, uint red_mask = 0, uint green_mask = 0, uint blue_mask = 0 )
	{
		 img = FreeImage_Allocate(width,height, bpp, red_mask , green_mask , blue_mask); 
	}
	
	//load
	this(FREE_IMAGE_FORMAT fif, const( char )* filename, int flags = 0)
	{
		img = FreeImage_Load(fif,filename,flags);
	} 
	
	//loadU
	this( FREE_IMAGE_FORMAT fif, const( wchar )* filename, int flags = 0)
	{
		img = FreeImage_LoadU(fif,filename,flags);
	}
	
	//loadFromHandle
	this( FREE_IMAGE_FORMAT fif, FreeImageIO* io, fi_handle handle, int flags = 0 )
	{
		img = FreeImage_LoadFromHandle(fif,io,handle,flags);
	}
	
	//loadFromMemory
	this( FREE_IMAGE_FORMAT fif, FIMEMORY* stream, int flags = 0 )
	{
		img = FreeImage_LoadFromMemory(fif, stream, flags);
	}
	
	~this()
	{
		FreeImage_Unload(img);
	}
	void unload()
	{
		destroy(this);
	}
	static FIBitmap allocate(int width, int height, int bpp, uint red_mask = 0, uint green_mask = 0, uint blue_mask = 0 )
	{
		return new FIBitmap(width,height, bpp, red_mask , green_mask , blue_mask);
	}
	static FIBitmap allocateT(FREE_IMAGE_TYPE type, int width, int height, int bpp = 8, uint red_mask = 0, uint green_mask = 0, uint blue_mask = 0)
	{
		return new FIBitmap(type, width, height, bpp = 8, red_mask,green_mask,blue_mask);
	}
	FIBitmap clone()
	{
		return new FIBitmap(FreeImage_Clone(img));
	}
	bool hasPixels()
	{
		return FreeImage_HasPixels(img)!=0;
	}
	static FIBitmap load(FREE_IMAGE_FORMAT fif, const( char )* filename, int flags = 0 )
	{
		return new FIBitmap(fif,filename,flags);
	}
	static FIBitmap loadU( FREE_IMAGE_FORMAT fif, const( wchar )* filename, int flags = 0 )
	{
		return new FIBitmap(fif,filename,flags);
	}
	
	static FIBitmap loadFromHandle( FREE_IMAGE_FORMAT fif, FreeImageIO* io, fi_handle handle, int flags = 0)
	{
		return new FIBitmap(fif,io,handle,flags);
	}
	
	static FIBitmap loadFromMemory( FREE_IMAGE_FORMAT fif, FIMEMORY* stream, int flags = 0 )
	{
		return new FIBitmap(fif,stream,flags);
	}
	
	bool save(FREE_IMAGE_FORMAT fif, const( char )* filename, int flags = 0 )
	{
		return FreeImage_Save(fif,img,filename,flags)!=0;
	}
	bool saveU( FREE_IMAGE_FORMAT fif, const( wchar )* filename, int flags = 0 )
	{
		return FreeImage_SaveU(fif,img,filename,flags)!=0;
	}
	bool saveToHandle(FREE_IMAGE_FORMAT fif,FreeImageIO* io, fi_handle handle, int flags = 0 )
	{
		return FreeImage_SaveToHandle(fif,img,io,handle,flags)!=0;
	}
	bool saveToMemory( FREE_IMAGE_FORMAT fif,FIMEMORY* stream, int flags = 0 )
	{
		return FreeImage_SaveToMemory(fif,img,stream,flags)!=0;
	}
	
}

class FIMemory()
{
	FIMEMORY *mem;
	//openMemory
	this( BYTE* data = null, DWORD size_in_bytes = 0 )
	{
		mem = FreeImage_OpenMemory(data,size_in_bytes);
	}
	
	~this()
	{
		FreeImage_CloseMemory(mem);
	}
	
	static FIMemory openMemory( BYTE* data = null, DWORD size_in_bytes = 0 )
	{
		return new FIMemory(data,size_in_bytes);
	}
	
	void closeMemory()
	{
		destroy(this);
	}
	
	long tellMemory()
	{
		return cast(long)(FreeImage_TellMemory(mem));
	}
	
	bool seekMemory(long offset, int origin)
	{
		return FreeImage_SeekMemory(mem, cast(c_long)(offset),origin)!=0;
	}
	
	bool acquireMemory(BYTE**data, DWORD* size_in_bytes )
	{
		return FreeImage_AcquireMemory(mem,data,size_in_bytes)!=0; 
	}
	
	//uint readMemory
	//uint writeMemory
	
}